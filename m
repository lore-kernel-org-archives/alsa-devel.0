From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.13rc3: relocation error: mocp:
	symbol	snd_pcm_hw_params_get_channels_min ..
Date: Fri, 29 Sep 2006 21:54:12 +0200
Message-ID: <20060929195412.GA2935@samweis.home.lxtec.de>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
	<20060927180756.GA5202@aragorn.home.lxtec.de>
	<s5h8xk5p10k.wl%tiwai@suse.de>
	<20060927194840.GA3542@samweis.home.lxtec.de>
	<s5h1wpwpa49.wl%tiwai@suse.de>
	<20060928180207.GA2855@samweis.home.lxtec.de>
	<s5hwt7n3s7v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hwt7n3s7v.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Sep 2006 the mental interface of
Takashi Iwai told:

[...]
> Could you recheck whether rc2 works and the patched rc3 really doesn't
> work again?

My apologies. I reworked all Debian patches. One has to relibtoolize
which I created wrong. rc3 works _*without*_ rediff the sym patch.

Sorry for the noise and thank you very much for cooperation.

Elimar


-- 
  Experience is something you don't get until 
  just after you need it!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
