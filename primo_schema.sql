--
-- Name: collaborators; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."collaborators" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "site" "uuid",
    "user" "uuid" NOT NULL,
    "role" "text" NOT NULL
);

ALTER TABLE
    "public"."collaborators" OWNER TO "postgres";

--
-- Name: collaborators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
ALTER TABLE
    "public"."collaborators"
ALTER COLUMN
    "id"
ADD
    GENERATED BY DEFAULT AS IDENTITY (
        SEQUENCE NAME "public"."collaborators_id_seq" START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1
    );

--
-- Name: config; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."config" (
    "id" "text" NOT NULL,
    "value" "text",
    "options" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);

ALTER TABLE
    "public"."config" OWNER TO "postgres";

--
-- Name: invitations; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."invitations" (
    "created_at" timestamp with time zone DEFAULT "now"(),
    "email" "text",
    "site" "uuid",
    "inviter_email" "text",
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "role" "text" NOT NULL,
    "server_invitation" boolean
);

ALTER TABLE
    "public"."invitations" OWNER TO "postgres";

INSERT INTO
    public.config (id, value, options, created_at, updated_at)
VALUES
    ('github_token', null, null, now(), now());

--
-- Name: pages; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."pages" (
    "code" "jsonb" DEFAULT '{"js": "", "css": "", "html": {"head": "", "below": ""}}' :: "jsonb",
    "name" "text",
    "fields" "jsonb" DEFAULT '[]' :: "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "url" "text",
    "content" "jsonb" DEFAULT '{}' :: "jsonb" NOT NULL,
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "site" "uuid" NOT NULL,
    "parent" "uuid"
);

ALTER TABLE
    "public"."pages" OWNER TO "postgres";

--
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."sections" (
    "content" "jsonb" DEFAULT '{"en": {}}' :: "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "index" smallint DEFAULT '1' :: smallint NOT NULL,
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "page" "uuid" NOT NULL,
    "symbol" "uuid" NOT NULL
);

ALTER TABLE
    "public"."sections" OWNER TO "postgres";

--
-- Name: server_members; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."server_members" (
    "id" bigint NOT NULL,
    "user" "uuid",
    "role" "text" DEFAULT 'DEV' :: "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "admin" boolean DEFAULT false
);

ALTER TABLE
    "public"."server_members" OWNER TO "postgres";

--
-- Name: server_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
ALTER TABLE
    "public"."server_members"
ALTER COLUMN
    "id"
ADD
    GENERATED BY DEFAULT AS IDENTITY (
        SEQUENCE NAME "public"."server_members_id_seq" START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1
    );

--
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."sites" (
    "id" "uuid" NOT NULL,
    "name" "text",
    "active_deployment" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "code" "jsonb" DEFAULT '{"js": "", "css": "", "html": {"head": "", "below": ""}}' :: "jsonb" NOT NULL,
    "fields" "jsonb" DEFAULT '[]' :: "jsonb" NOT NULL,
    "content" "jsonb" DEFAULT '{}' :: "jsonb" NOT NULL,
    "url" "text" NOT NULL
);

ALTER TABLE
    "public"."sites" OWNER TO "postgres";

--
-- Name: symbols; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."symbols" (
    "name" "text",
    "code" "jsonb" DEFAULT '{"js": "", "css": "", "html": ""}' :: "jsonb" NOT NULL,
    "fields" "jsonb" DEFAULT '[]' :: "jsonb" NOT NULL,
    "content" "jsonb" DEFAULT '{}' :: "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "site" "uuid" NOT NULL
);

ALTER TABLE
    "public"."symbols" OWNER TO "postgres";

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE "public"."users" (
    "email" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "id" "uuid" NOT NULL
);

ALTER TABLE
    "public"."users" OWNER TO "postgres";

--
-- Name: collaborators collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."collaborators"
ADD
    CONSTRAINT "collaborators_pkey" PRIMARY KEY ("id");

--
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."config"
ADD
    CONSTRAINT "config_pkey" PRIMARY KEY ("id");

--
-- Name: invitations invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."invitations"
ADD
    CONSTRAINT "invitations_pkey" PRIMARY KEY ("id");

--
-- Name: pages pages_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."pages"
ADD
    CONSTRAINT "pages_id_key" UNIQUE ("id");

--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."pages"
ADD
    CONSTRAINT "pages_pkey" PRIMARY KEY ("id");

--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."sections"
ADD
    CONSTRAINT "sections_pkey" PRIMARY KEY ("id");

--
-- Name: server_members server_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."server_members"
ADD
    CONSTRAINT "server_members_pkey" PRIMARY KEY ("id");

--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."sites"
ADD
    CONSTRAINT "sites_pkey" PRIMARY KEY ("id");

--
-- Name: sites sites_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."sites"
ADD
    CONSTRAINT "sites_url_key" UNIQUE ("url");

--
-- Name: symbols symbols_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."symbols"
ADD
    CONSTRAINT "symbols_id_key" UNIQUE ("id");

--
-- Name: symbols symbols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."symbols"
ADD
    CONSTRAINT "symbols_pkey" PRIMARY KEY ("id");

--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."users"
ADD
    CONSTRAINT "users_pkey" PRIMARY KEY ("id");

--
-- Name: collaborators collaborators_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."collaborators"
ADD
    CONSTRAINT "collaborators_site_fkey" FOREIGN KEY ("site") REFERENCES "public"."sites"("id");

--
-- Name: collaborators collaborators_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."collaborators"
ADD
    CONSTRAINT "collaborators_user_fkey" FOREIGN KEY ("user") REFERENCES "public"."users"("id");

--
-- Name: invitations invitations_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."invitations"
ADD
    CONSTRAINT "invitations_site_fkey" FOREIGN KEY ("site") REFERENCES "public"."sites"("id");

--
-- Name: pages pages_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."pages"
ADD
    CONSTRAINT "pages_parent_fkey" FOREIGN KEY ("parent") REFERENCES "public"."pages"("id");

--
-- Name: pages pages_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."pages"
ADD
    CONSTRAINT "pages_site_fkey" FOREIGN KEY ("site") REFERENCES "public"."sites"("id");

--
-- Name: sections sections_page_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."sections"
ADD
    CONSTRAINT "sections_page_fkey" FOREIGN KEY ("page") REFERENCES "public"."pages"("id");

--
-- Name: sections sections_symbol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."sections"
ADD
    CONSTRAINT "sections_symbol_fkey" FOREIGN KEY ("symbol") REFERENCES "public"."symbols"("id");

--
-- Name: server_members server_members_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."server_members"
ADD
    CONSTRAINT "server_members_user_fkey" FOREIGN KEY ("user") REFERENCES "public"."users"("id") ON DELETE CASCADE;

--
-- Name: symbols symbols_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE
    ONLY "public"."symbols"
ADD
    CONSTRAINT "symbols_site_fkey" FOREIGN KEY ("site") REFERENCES "public"."sites"("id");

-- Set Row Level Security
ALTER TABLE
    public.collaborators ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.config ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.invitations ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.pages ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.sections ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.server_members ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.sites ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.symbols ENABLE ROW LEVEL SECURITY;

ALTER TABLE
    public.users ENABLE ROW LEVEL SECURITY;

-- Set RLS Policy
CREATE POLICY "Enable ALL for authenticated users" ON "public"."collaborators" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."config" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."invitations" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."pages" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."sections" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."server_members" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."sites" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."symbols" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable ALL for authenticated users" ON "public"."users" AS PERMISSIVE FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Create storage buckets for site files and images
INSERT INTO
    storage.buckets (id, name, public)
VALUES
    ('sites', 'sites', TRUE),
    ('images', 'images', TRUE);

-- Set storage security
CREATE POLICY "Public access to view sites" ON storage.objects FOR
SELECT
    USING (((bucket_id = 'sites' :: text)));

CREATE POLICY "Give Authenticated users access to upload new sites" ON storage.objects FOR
INSERT
    WITH CHECK (
        (
            (bucket_id = 'sites' :: text)
            AND (auth.role() = 'authenticated' :: text)
        )
    );

CREATE POLICY "Give Authenticated users access to update sites" ON storage.objects FOR
UPDATE
    USING (
        (
            (bucket_id = 'sites' :: text)
            AND (auth.role() = 'authenticated' :: text)
        )
    );

CREATE POLICY "Give Authenticated users access to delete sites" ON storage.objects FOR DELETE USING (
    (
        (bucket_id = 'sites' :: text)
        AND (auth.role() = 'authenticated' :: text)
    )
);

-- Set storage security
CREATE POLICY "Public access to view images" ON storage.objects FOR
SELECT
    USING (((bucket_id = 'images' :: text)));

CREATE POLICY "Give Authenticated users access to upload new images" ON storage.objects FOR
INSERT
    WITH CHECK (
        (
            (bucket_id = 'images' :: text)
            AND (auth.role() = 'authenticated' :: text)
        )
    );

CREATE POLICY "Give Authenticated users access to update images" ON storage.objects FOR
UPDATE
    USING (
        (
            (bucket_id = 'images' :: text)
            AND (auth.role() = 'authenticated' :: text)
        )
    );

CREATE POLICY "Give Authenticated users access to delete images" ON storage.objects FOR DELETE USING (
    (
        (bucket_id = 'images' :: text)
        AND (auth.role() = 'authenticated' :: text)
    )
);