function CourseCard({
  id,
  name,
  code,
  credits,
  grade,
  onEnroll
}) {
  return (
    <div
      style={{
        border: "1px solid gray",
        padding: "15px",
        margin: "15px",
        borderRadius: "8px"
      }}
    >
      <h3>{name}</h3>

      <p>Code : {code}</p>

      <p>Credits : {credits}</p>

      <p>Grade : {grade}</p>

      <button onClick={() => onEnroll(id)}>
        Enroll
      </button>
    </div>
  );
}

export default CourseCard;