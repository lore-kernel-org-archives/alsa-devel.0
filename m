From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 0/4] add da9034 audio support for Littleton
	and generalize SSP I2S/LeftJ
Date: Wed, 3 Jun 2009 20:37:14 +0800
Message-ID: <f17812d70906030537k4ed45075qd666a09704636966@mail.gmail.com>
References: <f17812d70906030532x10aea8beo455ae63bda6bc26b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 14D932438D
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:37:15 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so4902377qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:37:15 -0700 (PDT)
In-Reply-To: <f17812d70906030532x10aea8beo455ae63bda6bc26b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, alsa-devel@alsa-project.org
Cc: Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 3, 2009 at 8:32 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Thanks for Paul's good work, and finally, we worked together to
> figure out the generalized I2S/LeftJ support in current pxa-ssp.c,
> and added the audio support for Littleton:
>

Sorry I forgot to mention Daniel, who was kindly enough to help
us test out the different SSP settings, greatly appreciated.
