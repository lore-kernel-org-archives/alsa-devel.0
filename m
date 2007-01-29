From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Mon, 29 Jan 2007 16:33:04 +0100
Message-ID: <20070129153301.GB2831@synertronixx3>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
	<45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
	<s5hac08cvct.wl%tiwai@suse.de>
	<20070125101319.GA3340@titan.lahn.de>
	<s5hd553bbfs.wl%tiwai@suse.de>
	<20070126202950.GA5721@titan.lahn.de>
	<s5hbqkhq4i6.wl%tiwai@suse.de>
	<20070129153011.GA2831@synertronixx3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070129153011.GA2831@synertronixx3>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Am 2007-01-29 16:30 +0100 schrieb Konstantin Kletschke:

> May be Philps patch needs only slight work, my approach of a

What I forgot to point out: It gives basic functionality but main
volume sliders are not working. Sound is constant at moderate
level. This is expected by me, since aureon.c seems to speak in spi
mode to wm8776, it needs i2c functions.

Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
