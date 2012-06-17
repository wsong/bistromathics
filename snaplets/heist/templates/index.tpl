<apply template="base">

<ifLoggedIn>
  <p>
    Welcome back, <loggedInUser/>!
    <apply template="logoutButton"/>
</ifLoggedIn>

<ifLoggedOut>
  <p>
    Have you ever been sick of arguing over whose turn it is to pay at
    dinner?  Have you ever wished that there was a technological solution
    for your stupid friends?  Wish no longer.
    <form action="login">
      <input type="submit" value="Login"/>
    </form>

    <form action="register">
      <input type="submit" value="Register"/>
    </form>
</ifLoggedOut>

</apply>
