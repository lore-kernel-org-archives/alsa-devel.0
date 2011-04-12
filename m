From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/7] ASoC: neo1973_wm8753: Remove scenario
 management code.
Date: Tue, 12 Apr 2011 22:02:46 +0200
Message-ID: <4DA4AFE6.8050007@metafoo.de>
References: <1299481500-5481-1-git-send-email-lars@metafoo.de>	<1299495878.3377.17.camel@odin>
	<20110307122520.GI13471@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id A238024450
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 22:02:20 +0200 (CEST)
In-Reply-To: <20110307122520.GI13471@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 03/07/2011 01:25 PM, Mark Brown wrote:
> On Mon, Mar 07, 2011 at 11:04:38AM +0000, Liam Girdwood wrote:
> 
>> Just had a quick look. All 
> 
>> Acked-by: Liam Girdwood <lrg@ti.com>
> 
> Applied 1-6 - I'll wait for Kukjin to check patch 7 just in case he
> wants it to go via his tree, there's no compile time dependency.

Thanks.

So far patch 7 (adding the dfbmcs320 platform device to gta02 mach file) hasn't
been applied. Should I resent it, or do you still have it?

- Lars
