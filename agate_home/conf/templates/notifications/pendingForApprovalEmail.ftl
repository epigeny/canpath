<!DOCTYPE html>
<head lang="en">
  <meta charset="UTF-8"/>
  <title></title>
</head>
<body style="margin: 0;font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;line-height: 1.5;color: #2c3e50;background-color: #ffffff;">

<div
  style="min-height: 20px;padding: 19px;margin-bottom: 20px;background-color: #ecf0f1;border: 1px solid transparent;border-radius: 4px;-webkit-box-shadow: none;box-shadow: none;">
  <div style="margin: auto;max-width: 700px;">
    <div style="margin-bottom: 21px;background-color: #ffffff;border-radius: 4px;-webkit-box-shadow: 0 1px 1px rgba(0,0,0,0.05);box-shadow: 0 1px 1px rgba(0,0,0,0.05);border: 1px solid gainsboro;">
      <div style="padding: 10px 15px;border-top-right-radius: 3px;border-top-left-radius: 3px;background-color: gainsboro;border-color: gainsboro;">
        <h3 style="font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-weight: 400;line-height: 1.1;color: inherit;margin-top: 0;margin-bottom: 0;font-size: 17px;">
          ${msg("email.pendingForApproval.title", organization)}
        </h3>
      </div>
      <div style="padding: 15px;">
        <div style="display: block;margin-left: auto;margin-right: auto;width: 150px;margin-bottom: 20px;">
          <img src="${publicUrl}/assets/images/logo-email.png"/>
        </div>
        <p style="margin: 0 0 10px;">
          ${msg("email.generic.presentation", user.firstName!"", user.lastName!"")}
        </p>
        <p style="margin: 0 0 10px;">
          ${msg("email.pendingForApproval.body", organization)}
        </p>
        <div style="margin: 30px 0 0;">
          <hr width="55%" size="1" align="left" style="padding: 0; margin-top: 0;"/>
          <p>
            ${msg("access-office")}
          </p>
        </div>
      </div>
    </div>
    <p style="display: block;margin: 5px 0 10px;color: #597ea2;">
      ${msg("email.generic.message")}
    </p>
  </div>
</div>

</body>
</html>

