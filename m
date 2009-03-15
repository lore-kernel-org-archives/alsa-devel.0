From: Daniel Mack <daniel@caiaq.de>
Subject: Re: broonie/sound-2.6.git rebase?
Date: Sun, 15 Mar 2009 22:13:00 +0100
Message-ID: <20090315211300.GC6977@buzzloop.caiaq.de>
References: <20090315204427.GA6977@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 65E7F244EF
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 22:13:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090315204427.GA6977@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 15, 2009 at 09:44:27PM +0100, Daniel Mack wrote:
> Could you rebase your broonie/sound-2.6.git to Linus' master? When
> trying to merge them, I currently get:

Aii, my bad. Forget it.

Daniel


> From git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6
>  * branch            pxa-ssp    -> FETCH_HEAD
> Auto-merging arch/arm/mach-shark/include/mach/io.h
> CONFLICT (content): Merge conflict in arch/arm/mach-shark/include/mach/io.h
> Auto-merging sound/soc/codecs/cs4270.c
> Auto-merging sound/soc/codecs/tlv320aic26.c
> Auto-merging sound/soc/codecs/wm8400.c
> CONFLICT (add/add): Merge conflict in sound/soc/codecs/wm8400.c
> Auto-merging sound/soc/codecs/wm8580.c
> CONFLICT (content): Merge conflict in sound/soc/codecs/wm8580.c
> Auto-merging sound/soc/pxa/pxa-ssp.c
> Auto-merging sound/soc/pxa/pxa2xx-ac97.c
> Auto-merging sound/soc/s3c24xx/s3c24xx-i2s.c
> Automatic merge failed; fix conflicts and then commit the result.
> 
> Or is there any mystery about git I still haven't fully understood?
