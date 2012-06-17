<html>
  <head>
    <title>Bistromathics | The Payment Proclaimer</title>
  </head>
  <body>
    <div align="center" style="font-family: sans-serif; margin-left: 20%; margin-right:20%">
      <h2>Login</h2>

      <ifLoggedIn>
        <p>
          You are already logged in!  Would you like to log out?
          <apply template="logoutButton"/>
      </ifLoggedIn>

      <ifLoggedOut>
        <p>
          <bind tag="action">login</bind>
          <apply template="userform"/>
      </ifLoggedOut>
    </div>
  </body>
</html>
