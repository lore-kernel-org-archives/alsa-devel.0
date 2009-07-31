From: Daniel Mack <daniel@caiaq.de>
Subject: Re: DMA HW bug in MX2x platforms?
Date: Fri, 31 Jul 2009 11:52:51 +0200
Message-ID: <20090731095251.GF13236@buzzloop.caiaq.de>
References: <eedb5540907240037u2cb8fbfap84f02727621261d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 36A71243F2
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 11:52:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540907240037u2cb8fbfap84f02727621261d9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 24, 2009 at 09:37:33AM +0200, javier Martin wrote:
> I am currently working on an ASoC driver for mx2x platforms. I am
> porting an old working ASoC driver for 2.6.22 + Freescale BSP kernel
> to current 2.6.30 kernel.

Will the SSI/I2S part be compatible to mx3 platforms or are the register
set too different?

Daniel
