From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 11/18] dt-bindings: pinctrl: Add
 bindings for Cirrus Logic Madera codecs
Date: Tue, 25 Apr 2017 11:35:02 +0200
Message-ID: <CACRpkdZrSr6Ws+r3JAz22C0GJ65i_R+o3uUKVYpiPqYF0igZBg@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-12-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id BD126266EF2
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 11:35:04 +0200 (CEST)
Received: by mail-io0-f175.google.com with SMTP id k87so212884809ioi.0
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 02:35:04 -0700 (PDT)
In-Reply-To: <1493050124-5970-12-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> This is the binding description of the pinctrl driver for Cirru Logic
> Madera codecs. The binding uses the generic pinctrl binding so  the main
> purpose here is to describe the device-specific names for groups and
> functions.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Changes since V1:
> - split out from main pinctrl patch into a separate patch
> - fixed typo in pinctrl-names property description

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
