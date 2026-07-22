function Header({ siteName, enrolledCount }) {
  return (
    <header
      style={{
        background: "#1976d2",
        color: "white",
        padding: "15px"
      }}
    >
      <h2>{siteName}</h2>

      <nav>
        Home | Courses | Profile
      </nav>

      <h4>Enrolled Courses : {enrolledCount}</h4>
    </header>
  );
}

export default Header;