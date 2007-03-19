From: Fons Adriaensen <fons@kokkinizita.net>
Subject: Re: [RFC] Standard for Multichannel Mixer Control Names
Date: Mon, 19 Mar 2007 16:22:21 +0100
Message-ID: <20070319152221.GA6096@linux-2.site>
References: <45FC62FA.5080403@earthlink.net> <s5h648xjo20.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from wp097.webpack.hosteurope.de (wp097.webpack.hosteurope.de
	[80.237.132.104])
	by alsa0.perex.cz (Postfix) with ESMTP id C39262464D
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2007 16:17:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h648xjo20.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2007 at 03:38:47PM +0100, Takashi Iwai wrote:

> The master PCM volume control
> 	PCM
> =

> The PCM surround volume controls (optional)
> 	PCM Front
> 	PCM Surround
> 	PCM Center
> 	PCM LFE
> 	PCM Side


Could be just me, but whenever see a mixer control named "PCM" I have =

to think about what it could be. "PCM" refers to a signal format, not
to a source or destination of audio data. It's a complete misnomer for
a mixer control. =



-- =

FA

Follie! Follie! Delirio vano =E8 questo !



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
