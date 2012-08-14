From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/22] ASoC: codecs: Enable AB8500 CODEC
	for Device Tree
Date: Tue, 14 Aug 2012 13:09:33 +0200
Message-ID: <CACRpkdZtfmsSUxn91ebArALT6gyTg_59EcRhqZVzP=Ff11dhYw@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 86422265E63
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 12:39:48 +0200 (CEST)
Received: by vcqp16 with SMTP id p16so184255vcq.38
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 04:09:34 -0700 (PDT)
In-Reply-To: <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Ola LILJA2 <ola.o.lilja@stericsson.com>, Ola Lilja <olalilja@yahoo.se>
Cc: alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> We continue to allow the AB8500 CODEC to be registered via the AB8500
> Multi Functional Device API, only this time we extract its configuration
> from the Device Tree binary.
>
> CC: alsa-devel@alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Also for Ola to look at, and/or ACK.
I dare not even ACK patches like this.

Yours,
Linus Walleij
