From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] Blackfin: bf537: Stamp: Register ASoC
 EVAL-ADAU1373 board driver
Date: Thu, 18 Aug 2011 15:52:49 +0200
Message-ID: <4E4D1931.2070303@metafoo.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-4-git-send-email-lars@metafoo.de>
	<20110816155606.GG15484@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ADB9243A0
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 15:55:26 +0200 (CEST)
In-Reply-To: <20110816155606.GG15484@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/16/2011 05:56 PM, Mark Brown wrote:
> On Mon, Aug 15, 2011 at 08:15:24PM +0200, Lars-Peter Clausen wrote:
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Mike Frysinger <vapier@gentoo.org>
> 
> I'm OK with this but may as well go via the blackfin tree as there's no
> code dependency on any of the ASoC stuff and it reduces the risk of any
> collisions with other blackfin work.  If you guys would prefer that it
> goes via ASoC then I can apply it there though.

We'll try to let this go through the blackfin tree.

Thanks
- Lars
