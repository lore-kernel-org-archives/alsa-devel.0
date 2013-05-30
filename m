From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/10] ASoC: blackfin: Remove unused
 bf5xx-{i2s, tdm, ac97}-pcm.h
Date: Thu, 30 May 2013 13:06:05 +0200
Message-ID: <51A7329D.50809@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
 <20130529192726.GA5180@sirena.org.uk> <51A70402.2070901@metafoo.de>
 <20130530104703.GE5180@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id DCDA826109D
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 13:03:00 +0200 (CEST)
In-Reply-To: <20130530104703.GE5180@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Steven Miao <realmz6@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/30/2013 12:47 PM, Mark Brown wrote:
> On Thu, May 30, 2013 at 09:47:14AM +0200, Lars-Peter Clausen wrote:
> 
>> Hm, where exactly are you getting conflicts? If I download the patches
>> as they are in the ml-archive and run git am on them on top of
>> topic/blackfin everything applies cleanly.
> 
> Patch 3 IIRC.

Even if I re-generate the patches on-top of today's asoc/topic/blackfin (or
asoc/for-next) they are still 100% identical to what I sent in this series.
So I can resend the series but it will be identical to this one.

- Lars
