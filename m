From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: fix warnings when kernel
 compiled without GPIOLIB support
Date: Thu, 16 Oct 2014 09:34:15 -0700
Message-ID: <CAOMFOmWZV+dxgfYVychwswVR15FKyQZm8sQP_LUNvGNQgLZ_qg@mail.gmail.com>
References: <1413390649-854-1-git-send-email-anatol.pomozov@gmail.com>
 <20141016074351.GB724@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 113FC2605DB
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 18:34:16 +0200 (CEST)
Received: by mail-vc0-f182.google.com with SMTP id la4so2929968vcb.41
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 09:34:16 -0700 (PDT)
In-Reply-To: <20141016074351.GB724@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Oct 16, 2014 at 12:43 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 15, 2014 at 09:30:49AM -0700, Anatol Pomozov wrote:
>> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
>
> This doesn't apply against current code, please check and resend.

Ok, I will rebase it on top of topic/rt5677 branch.
