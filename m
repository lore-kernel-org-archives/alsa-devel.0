From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/2] ASoC: omap-mcbsp: dma_op_mode changes
Date: Fri, 16 Mar 2012 08:29:48 +0200
Message-ID: <4F62DDDC.5080108@bitmer.com>
References: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
	<20120315122256.GI3138@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E79A103DE6
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 07:29:52 +0100 (CET)
In-Reply-To: <20120315122256.GI3138@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/15/2012 02:22 PM, Mark Brown wrote:
> On Thu, Mar 15, 2012 at 12:37:12PM +0200, Peter Ujfalusi wrote:
>> Hello,
>>
>> Removing the frame dm_op_mode, and using packet mode in element mode on
>> OMAP3+ to transfer 1 sample at the time between the McBSP FIFO and memory.
> 
> Both
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
