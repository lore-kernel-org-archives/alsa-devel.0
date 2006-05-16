From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: question about closed source alsa driver
Date: Tue, 16 May 2006 10:55:19 -0400
Message-ID: <1147791320.13948.111.camel@mindpipe>
References: <d39e2e70605160318meac7c91g40bb9cd7a85c0665@mail.gmail.com>
	 <4469CE12.6090701@findus.dhs.org>
	 <d39e2e70605160637g153bd27ei3cc3dc28df59dba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <d39e2e70605160637g153bd27ei3cc3dc28df59dba1@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Kolosov <freeserj@gmail.com>
Cc: Petter =?ISO-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-16 at 17:37 +0400, Sergey Kolosov wrote:
> Whether me interests if I shall write closed source alsa driver there
> will be it violations gpl?
>=20

No you cannot.  The ALSA driver core is GPL so all drivers must be GPL.

Why do you need to hide the hardware details?  It's just a sound card.

Lee

> On 5/16/06, Petter Sundl=F6f <petter.sundlof@findus.dhs.org> wrote:
>         Question is, in my mind: Should you?
>        =20
>         Sergey Kolosov wrote:
>         > Can i  write closed source alsa-driver? If it possible what
>         rules I must
>         > succeed(etc. can I use alsa function or I must implement it
>         anew?).
>         >
>         > P.S.
>         > It is not my initiative, but license agreement.=20
>=20



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
