From: Eric Shattow <lucent@gmail.com>
Subject: Re: Bounty: Polypaudio ALSA plugin
Date: Sun, 11 Dec 2005 16:42:35 -0600
Message-ID: <2c746f620512111442l5092db4bv3c38ead9f10c5323@mail.gmail.com>
References: <Pine.LNX.4.64.0512072314450.26327@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0512072314450.26327@maggie.lkpg.cendio.se>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Peter_=C5strand?= <astrand@cendio.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter,

Comment for you from a casual ALSA user:  This is a good approach to
take. I hope that there are interested developers.

Best wishes,

 Eric

On 12/7/05, Peter =C5strand <astrand@cendio.se> wrote:
>
> Hi all, and thanks for doing a great job. Let me introduce myself: I'm th=
e
> chief developer at Cendio, which develops the ThinLinc thin client produc=
t.
> Currently, we are using Esound to provide sound playback and recording fr=
om
> thin clients. Esound has many disadvantages, though, and we are consideri=
ng
> replacing it with Polypaudio (PA).
>
> One thing remains, though: Achieving near 100% application compatibility.
> The number of applications with PA support is fairly low. It would be gre=
at
> if all ALSA-enabled applications could be networked with PA. I've talked =
to
> many people about this, and there seems to be a general consensus that th=
e
> right solution is to push a networked audio protocol/layer below ALSA. We
> think that this network layer should be PA.
>
> The author of Polypaudio, Lennart Poettering, thinks is approach is a goo=
d
> idea as well. As I understand it, the plugin would be similiar to the JAC=
K
> plugin, included in the the alsa-plugins package.
>
> Cendio AB is interested in solving this problem in the near future.
> Therefore, we offer a bounty to the organization or individual that
> implements this functionality. The details are:
>
> * You will recieve 1000 EUR when the project is finished. This means
>    that the "plugin" should be written. The necessary ALSA modifications
>    should be done and also accepted by the ALSA project.
>
> * The finished plugin should be Open Source and available via anonymous
>    CVS or Subversion.
>
> * The software README should mention that Cendio AB has
>    sponsored this work.
>
> Please contact me if you have any questions or are interested in this
> bounty.
>
> Regards,
> ---
> Peter =C5strand           Chief Developer
> Cendio                  www.thinlinc.com
> Teknikringen 3          www.cendio.se
> 583 30 Link=F6ping        Phone: +46-13-21 46 00
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
