import Link from "@/components/Link";
import styles from "../../styles/Home.module.scss";
import axios from "axios";
import Head from "next/head";
import { AiOutlineUser } from "react-icons/ai";
const LinkView = (props) => {
  //   console.log(router.query["username"]);
  console.log(props.data);
  return typeof props.data !== "string" ? (
    <div className={styles.link_preview}>
      <Head>
        <title>WeLink | {props.data.profile_title}</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      </Head>
      <div className={styles.center}>
        <div className={styles.avatar}>
          {props.data.avatar ? (
            <img src={`http://127.0.0.1:8000${props.data.avatar}`} alt="" />
          ) : (
            <>
              <AiOutlineUser color="#44a3f15f" size={25} />{" "}
            </>
          )}
        </div>
        <h1>{props.data.profile_title}</h1>
        <p>{props.data.description}</p>
        <div className={styles.link_list}>
          {props.data.links.map((e) => (
            <Link title={e.label} link={e.href} icon={e.icon} />
          ))}
        </div>
      </div>
    </div>
  ) : (
    <section className={styles.link_preview}>{props.data}</section>
  );
};
export async function getServerSideProps(context) {
  const slug = context.params.username;

  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/api/profile/${slug}`
    );
    console.log(response.status);

    return {
      props: {
        data: response.data["data"],
      },
    };
  } catch (error) {
    console.log(error.response.status);
    switch (error.response.status) {
      case 404:
        return {
          props: {
            data: "User does't exist",
          },
        };
      default:
        return {
          props: {
            data: "Something went wrong",
          },
        };
    }
  }
}

export default LinkView;
