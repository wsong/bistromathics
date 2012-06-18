<apply template="base">

<h2>Register</h2>
  <ifLoggedIn>
    <p>
      You are already registered!  Would you like to log out?
      <apply template="logoutButton"/>
    </p>
  </ifLoggedIn>

  <registerError/>

  <ifLoggedOut>
    <p>
      <bind tag="action">register</bind>
      <apply template="userform"/>
    </p>
  </ifLoggedOut>
</apply>
