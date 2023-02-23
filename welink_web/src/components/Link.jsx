import styles from "../styles/Home.module.scss";
const Link = ({ title, icon, link }) => {
  return (
    <div className={styles.link}>
      <div className={styles.icon}>
        <img src={`http://127.0.0.1:8000${icon}`} alt="" />
      </div>
      <div className={styles.data}>
        <h4>{title}</h4>
        <p>{link}</p>
      </div>
    </div>
  );
};

export default Link;
