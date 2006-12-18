From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ive got 2 working implementations of the
	loopback	snd-aloop device
Date: Mon, 18 Dec 2006 12:47:20 -0500
Message-ID: <1166464041.17059.85.camel@mindpipe>
References: <20061217123945.GM15973@mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061217123945.GM15973@mathematik.uni-freiburg.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ahmet =?iso-8859-9?Q?=DDnan?= <ainan@mathematik.uni-freiburg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-12-17 at 13:39 +0100, Ahmet =DDnan wrote:
> reason:
> aoss doesnt always work for me. and imho is not the right way.
> LD_PRELOAD'ing is just plain braindamaged, it couses more trouble than
> it solves. telling vendors to use alsa also doesnt help.
> me wants mixing very bad. me wants network transparency for all apps.
> =


This seems like a lot of wasted cycles just to make life easier for lazy
application programmers.

Telling vendors to use ALSA does indeed help - the latest releases of
Flash and Skype support ALSA natively.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
