const BUTTON_PREVIOUS = 'button-previous';
const BUTTON_FIRST = 'button-first';
const BUTTON_LAST = 'button-last';
const BUTTON_NEXT = 'button-next';
const BUTTON_PAGE = 'button-page';
const BUTTON_ELLIPSIS_FIRST = 'button-ellipsis-first';
const BUTTON_ELLIPSIS_LAST = 'button-ellipsis-last';

/**
 * Simple widget used for selecting pagination page size.
 * Client code must have a '<select>' element with an ID that is passed to this widget for proper rendering.
 */
class OBiBaPageSizeSelector {
  constructor(elementId, pageSizes, pageSize, pageSizeChangeCB) {
    this.elementId = elementId;
    this.pageSizes = pageSizes || [10, 20, 50, 100];
    this.pageSize = pageSizes.indexOf(pageSize) > 0 ? pageSize : pageSizes[0];
    this.pageSizeChangeCB = pageSizeChangeCB;
    this.__createOptions();
  }

  __createOptions() {
    const parent = document.querySelector(`select#${this.elementId}`);

    if (parent) {
      parent.addEventListener('change', this.__onPageSizeChanged.bind(this));

      this.pageSizes.forEach(pageSize => {
        parent.insertAdjacentHTML('beforeend', `<option id="PAGE-SIZE-${pageSize}" value="${pageSize}">${pageSize}</option>`);
      });

      parent.value = this.pageSize;
    }
  }

  __onPageSizeChanged(event) {
    if (this.pageSizeChangeCB) {
      this.pageSizeChangeCB({id: this.elementId, size: parseInt(event.target.value)});
    }
  }

  update(pageSize) {
    if (this.pageSizes.indexOf(pageSize) < 0) {
      throw new Error("Invalid pageSize");
    }

    const parent = document.querySelector(`select#${this.elementId}`);
    this.pageSize = pageSize;
    parent.value = this.pageSize;
  }
}

/**
 * Simple widget for content pagination.
 * Client code must have a '<nav id="obiba-pagination"><ul class="pagination"></ul></nav>' element with an ID that is
 * passed to this widget for proper rendering.
 */
class OBiBaPagination {

  constructor(elementId, useFixedFirstLast, onPageChangeCB) {
    this.elementId = elementId;
    this.page = 1;
    this.useFixedFirstLast = useFixedFirstLast;
    this.onPageChangeCB = onPageChangeCB ? onPageChangeCB : () => ({});
    this.numberOfPages = 0; // Fields initialized in OBiBaPagination::update()
    // TODO make 'numberOfButtons' configurable
    this.numberOfButtons = 3; // # of buttons showing the page number excluding (<<, <, ..., >, >>)
    this.pageButtons = [1,2,3];  // used to control the DEFAULT_BUTTONS
    this.hasFirstLastButtons = false;
  }

  __cleanup() {
    // Most browsers is supposed to remove EventListeners as well
    document.querySelectorAll(`#${this.elementId} ul [id^="button-"]`).forEach(button => {
      switch (button.id) {
        case BUTTON_FIRST:
          button.removeEventListener('click', this.__onFirstClick);
          break;
        case BUTTON_PREVIOUS:
          button.removeEventListener('click', this.__onPreviousClick);
          break;
        case BUTTON_NEXT:
          button.removeEventListener('click', this.__onFirstClick);
          break;
        case BUTTON_ELLIPSIS_FIRST:
        case BUTTON_ELLIPSIS_LAST:
          break;
        case BUTTON_LAST:
          button.removeEventListener('click', this.__onLastClick);
          break;
        default:
          button.removeEventListener('click', this.__onPageClick);
          break;
      }

      button.closest('li').remove();
    });
  }

  __initializeSelection(start, count) {
      return Array(count).fill().map((_, idx) => start + idx);
  }

  __updateSelection(start, count) {
    if (this.numberOfPages > this.numberOfButtons ) {
      this.pageButtons = this.__initializeSelection(start, count);
    }
  }

  __createButton(parent, id, data, label, clickHandler) {
    parent.insertAdjacentHTML(
      'beforeend',
      `<li class="page-item"><a id="${id}" class="page-link" href="javascript:void(0)">${label}</a></li>`
    );

    const button = document.querySelector(`#${this.elementId} #${id}`);

    if (data) {
      button.dataset.page = data;
    }

    if (clickHandler) {
      button.addEventListener('click', clickHandler);
    }
  }

  __addClass(id, clazz) {
    const button = document.querySelector(`#${this.elementId} #${id}`);
    button.closest('li').classList.add(clazz);
  }

  __removeClass(id, clazz) {
    const button = document.querySelector(`#${this.elementId} #${id}`);
    button.closest('li').classList.remove(clazz);
  }

  __enableButton(id, enable) {
    if (enable) {
      this.__removeClass(id, 'disabled');
    } else {
      this.__addClass(id, 'disabled')
    }
  }

  __visible(id, show) {
    if (show) {
      this.__removeClass(id,'d-none');
    } else {
      this.__addClass(id,'d-none');
    }
  }

  __deactivateButton(id) {
    this.__removeClass(id, 'active');
  }

  __activateButton(id) {
    this.__addClass(id, 'active');
  }

  __createButtons() {
    let parent = document.querySelector(`#${this.elementId} ul`);

    // Previous button
    this.__createButton(parent, BUTTON_PREVIOUS, null, this.useFixedFirstLast ? '&lsaquo;' : 'Previous', this.__onPreviousClick.bind(this));
    this.__enableButton(BUTTON_PREVIOUS, false);

    // create first Ellipsis button
    this.__createButton(parent, BUTTON_ELLIPSIS_FIRST, null, '...');
    this.__enableButton(BUTTON_ELLIPSIS_FIRST, false);
    this.__visible(BUTTON_ELLIPSIS_FIRST, false);

    // Page buttons
    this.pageButtons.forEach((p, index) => {
      this.__createButton(parent,  `${BUTTON_PAGE}-${p}`, p, `${p}`, this.__onPageClick.bind(this));
      if (index === 0) {
        this.__activateButton(`${BUTTON_PAGE}-${p}`);
      }
    });

    // create last Ellipsis button
    this.__createButton(parent, BUTTON_ELLIPSIS_LAST, null, '...');
    this.__enableButton(BUTTON_ELLIPSIS_LAST, false);
    this.__visible(BUTTON_ELLIPSIS_LAST, this.numberOfPages > this.numberOfButtons);

    // Next button
    this.__createButton(parent, BUTTON_NEXT, null, this.useFixedFirstLast ? '&rsaquo;' : 'Next', this.__onNextClick.bind(this));

    // First/Last
    if (this.useFixedFirstLast) {
      this.__createFixedFirstLastButtons();

    } else {
      this.__createFirstLastButtons();
    }
  }

  __createFixedFirstLastButtons() {
    let button = document.querySelector(`#${this.elementId} #${BUTTON_PREVIOUS}`);
    button.closest('li').insertAdjacentHTML(
      'beforebegin',
      `<li class="page-item"><a id="${BUTTON_FIRST}" class="page-link" href="javascript:void(0)">&laquo;</a></li>`
    );

    button = document.querySelector(`#${this.elementId} #${BUTTON_FIRST}`);
    button.dataset.page = 1;
    this.__visible(BUTTON_FIRST, true);
    button.addEventListener('click', this.__onFirstClick.bind(this));

    button = document.querySelector(`#${this.elementId} #${BUTTON_NEXT}`);
    button.closest('li').insertAdjacentHTML(
      'afterend',
      `<li class="page-item"><a id="${BUTTON_LAST}" class="page-link" href="javascript:void(0)">&raquo;</a></li>`
    );
    button = document.querySelector(`#${this.elementId} #${BUTTON_LAST}`);
    button.dataset.page = this.numberOfPages;
    this.__visible(BUTTON_LAST, true);
    button.addEventListener('click', this.__onLastClick.bind(this));
  }

  __createFirstLastButtons() {
    let button = document.querySelector(`#${this.elementId} #${BUTTON_PREVIOUS}`);
    button.closest('li').insertAdjacentHTML(
      'afterend',
      `<li class="page-item"><a id="${BUTTON_FIRST}" class="page-link" href="javascript:void(0)">1</a></li>`
    );

    button = document.querySelector(`#${this.elementId} #${BUTTON_FIRST}`);
    button.dataset.page = 1;
    this.__visible(BUTTON_FIRST, false);
    button.addEventListener('click', this.__onFirstClick.bind(this));

    button = document.querySelector(`#${this.elementId} #${BUTTON_NEXT}`);
    button.closest('li').insertAdjacentHTML(
      'beforebegin',
      `<li class="page-item"><a id="${BUTTON_LAST}" class="page-link" href="javascript:void(0)">${this.numberOfPages}</a></li>`
    );
    button = document.querySelector(`#${this.elementId} #${BUTTON_LAST}`);
    button.dataset.page = this.numberOfPages;
    this.__visible(BUTTON_LAST, false);
    button.addEventListener('click', this.__onLastClick.bind(this));
  }

  __updateVisibility() {
    const pagination = document.querySelector(`#${this.elementId}`);
    if (this.numberOfPages === 1) {
      pagination.classList.add('d-none');
    } else {
      pagination.classList.remove('d-none');
    }
  }

  __updateButtons() {
    const anchors = document.querySelectorAll(`#${this.elementId} ul [id^="${BUTTON_PAGE}"]`);
    anchors.forEach((a, index) => {
      this.__deactivateButton(a.id);
      a.dataset.page = this.pageButtons[index];
      a.dataset.page = this.pageButtons[index];
      a.innerHTML = a.dataset.page;
    });

    const selected = this.pageButtons.indexOf(this.page);
    this.__activateButton(anchors[selected].id);
  }

  __doPageChange(page) {
    const isFirstPage = page === 1;
    const isFirstSelection = this.pageButtons.indexOf(page) === 0;
    const isLastSelection = this.pageButtons.indexOf(page) === this.numberOfButtons - 1;
    const isLastPage = page === this.numberOfPages;
    this.page = page;

    this.__enableButton(BUTTON_PREVIOUS, this.numberOfPages  > 1);
    this.__enableButton(BUTTON_NEXT, this.numberOfPages  > 1);

    if (isFirstPage) {
      this.__enableButton(BUTTON_PREVIOUS,false);
      this.__updateSelection(1, this.numberOfButtons);
    } else if (isLastPage) {
      this.__enableButton(BUTTON_NEXT, false);
      this.__updateSelection(this.numberOfPages-2, this.numberOfPages);
    } else if (isLastSelection || isFirstSelection) {
      this.__updateSelection(page-1, this.numberOfButtons);
    }

    if (this.numberOfPages > this.numberOfButtons) {
      this.__visible(BUTTON_ELLIPSIS_FIRST, page > 2)
      this.__visible(BUTTON_ELLIPSIS_LAST, this.numberOfPages - page > 1)
    }

    this.__updateFirstLastButtons(page);
    this.__updateButtons();
  }

  __doPageChangeAndCallback(page) {
    this.__doPageChange(page);

    if (this.onPageChangeCB) {
      this.onPageChangeCB({
        id: this.elementId,
        size: this.pageSize,
        total: this.total,
        from: (this.page - 1) * this.pageSize,
        to: (this.page) * this.pageSize
      });
    }
  }

  __updateFirstLastButtons(page) {
    if (this.hasFirstLastButtons) {
      this.__visible(BUTTON_FIRST, this.pageButtons[0] > 2 || page > 2);
      this.__visible(BUTTON_ELLIPSIS_FIRST, this.pageButtons[0] > 2);
      this.__visible(BUTTON_LAST, this.numberOfPages - this.pageButtons[2] > 2 || this.numberOfPages - page > 1);
      this.__visible(BUTTON_ELLIPSIS_LAST, this.numberOfPages - this.pageButtons[2] > 1);
    } else if (this.useFixedFirstLast) {
      this.__enableButton(BUTTON_LAST, page < this.numberOfPages);
      this.__enableButton(BUTTON_FIRST, page > 1);
    }
  }

  __onPageClick(event) {
    const page = parseInt(event.target.dataset.page);
    this.__doPageChangeAndCallback(page);
  }

  __onPreviousClick(event) {
    this.__doPageChangeAndCallback(this.page-1);
  }

  __onFirstClick(event) {
    this.__doPageChangeAndCallback(1);
  }

  __onLastClick(event) {
    this.__doPageChangeAndCallback(this.numberOfPages);
  }

  __onNextClick(event) {
    this.__doPageChangeAndCallback(this.page+1);
  }

  __normalizePage(page) {
    let normalizedPage = page;
    if (page < 1) normalizedPage = 1;
    else if (page > this.numberOfPages) normalizedPage = this.numberOfPages;

    if (this.pageButtons.indexOf(normalizedPage) < 0) {
      // update selection before changing page
      this.__updateSelection(normalizedPage-2,normalizedPage);
    }

    return normalizedPage;
  }

  update(total, pageSize, page) {
    this.__cleanup();
    this.total = total;
    this.pageSize = pageSize;
    this.numberOfPages = Math.ceil(this.total / this.pageSize);
    this.numberOfButtons = Math.min(this.numberOfPages, 3);
    this.pageButtons = this.__initializeSelection(1,this.numberOfButtons);
    this.hasFirstLastButtons = !this.useFixedFirstLast && 2 < this.numberOfPages - this.numberOfButtons; // creates first/last button
    this.__createButtons();
    this.__doPageChange(this.__normalizePage(page));
    this.__updateVisibility();
  }

  gotoPage(page) {
    this.__doPageChange(this.__normalizePage(page));
  }

  gotoFrom(from) {
    if (from % this.pageSize !== 0) {
      throw new Error(`Invalid from value: ${from}. The valid value must be divisible by ${this.pageSize}.`);
    }

    this.gotoPage((from/this.pageSize)+1)
  }

  changePageSize(pageSize) {
    this.pageSize = pageSize;
    this.__cleanup();
    this.update(this.total, this.pageSize, this.page);
  }

  toString() {
    return `
      Total: ${this.total}
      Number of Pages: ${this.numberOfPages}
      Number of Buttons: ${this.numberOfPages}
      Page Size: ${this.pageSize}
      Page: ${this.page}
      Selections: ${this.pageButtons}
    `;
  }

}