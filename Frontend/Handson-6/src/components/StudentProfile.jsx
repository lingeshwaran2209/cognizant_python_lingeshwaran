import { useState } from "react";

function StudentProfile() {

  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [semester, setSemester] = useState("");

  return (
    <div>

      <h2>Student Profile</h2>

      <input
        placeholder="Name"
        value={name}
        onChange={(e)=>setName(e.target.value)}
      />

      <br /><br />

      <input
        placeholder="Email"
        value={email}
        onChange={(e)=>setEmail(e.target.value)}
      />

      <br /><br />

      <input
        placeholder="Semester"
        value={semester}
        onChange={(e)=>setSemester(e.target.value)}
      />

      <br /><br />

      <h4>Name : {name}</h4>
      <h4>Email : {email}</h4>
      <h4>Semester : {semester}</h4>

    </div>
  );
}

export default StudentProfile;