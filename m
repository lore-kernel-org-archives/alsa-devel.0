From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: AD1836: Fix build error
Date: Tue, 7 Jun 2011 09:33:17 +0100
Message-ID: <4DEDE24D.7070105@ti.com>
References: <20110607115505.71c9a330.sfr@canb.auug.org.au>
	<1307422979-14160-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6355D1038E1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:33:22 +0200 (CEST)
In-Reply-To: <1307422979-14160-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

On 07/06/11 06:02, Lars-Peter Clausen wrote:
> Commit f97d0c6d5f94 ("ASoC: AD1836: Add input gain control for ADC2") contained
> a typo in the register name, causing a build error. This patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 

Acked-by: Liam Girdwood <lrg@ti.com>
