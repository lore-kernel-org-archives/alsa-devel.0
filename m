From: Rene Rebe <rene.rebe@gmx.net>
Subject: Re: Problem with __OLD_GET
Date: Fri, 16 Jan 2004 23:57:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040116.235721.893793324.rene.rebe@gmx.net>
References: <opr1tl8sroq1sf88@mail.broadpark.no>
	<s5h7jzren70.wl@alsa2.suse.de>
	<opr1vzubwoq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <opr1vzubwoq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: aknuds-1@broadpark.no
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On: Fri, 16 Jan 2004 22:12:01 +0100,
    Arve Knudsen <aknuds-1@broadpark.no> wrote:
> Hi, Takashi
> =

> I have no experience with libtool myself, but from what I can see the=
 =

> plugin host (beep-media-player) uses it. libtool --version tells me t=
his: =

> ltmain.sh (GNU libtool) 1.4.3 (1.922.2.111 2002/10/23 02:54:36). But =
at =

> the same time we have another person, Rene Rebe, posting about a simi=
lar =

> problem and who does not appear to be using libtool (correct me here =
if =

> I'm mistaken).

Nope I do not use libtool - I posted the exact g{cc,++} lines used for
compiling and linking.

Althought it should not be that needed to track this down, our sources
are at:

  http://svn.rocklinux-consulting.de/gsmp/trunk/lowlevel/

they are not yet that advanced and only the tip of the iceberg of a
heavy cleanup/rewrite ...

Yours,
  Ren=E9

--  =

Ren=E9 Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
