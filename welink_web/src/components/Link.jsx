import styles from "../styles/Home.module.scss";
import axios from "axios";
import { useRouter } from "next/navigation";

const Link = ({ id, title, icon, link, style, radius }) => {
  const router = useRouter();

  console.log(style);

  async function handleClick(id) {
    console.log("clicked");
    try {
      const { data } = await axios.post(
        `http://127.0.0.1:8000/api/click/record/${id}`,
        {
          headers: {
            "Content-Type": "application/json",
          },
        }
      );
      router.push(`https://www.${link}`);
    } catch (error) {
      alert("Could't record the click");
      router.push(`https://www.${link}`);
    }
  }
  return (
    // <a
    //   href={`https://www.${link}`}
    //   target="_blank"
    //   onClick={() => handleClick(id)}
    // >
    <div
      onClick={() => handleClick(id)}
      className={`${styles.link} ${
        style.isHardShadow
          ? styles.shadow_hard
          : style.isSoftShadow
          ? styles.shadow_soft
          : ""
      } `}
      style={{ borderRadius: radius }}
    >
      <div className={styles.icon}>
        <img src={icon} alt="" />
      </div>
      <div className={styles.data}>
        <h4>{title}</h4>
        <p>{link.length < 35 ? link : link.substring(0, 35) + "....."}</p>
      </div>
    </div>
  );
};

export default Link;
