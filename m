From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: fix warnings when kernel
 compiled without GPIOLIB support
Date: Fri, 17 Oct 2014 06:06:53 -0700
Message-ID: <CAOMFOmUzjabYigfRkOYgocf8YrvRpxLaVeUdKfTVk5juKM25vA@mail.gmail.com>
References: <1413477658-35049-1-git-send-email-anatol.pomozov@gmail.com>
 <20141017094838.GA1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id D835726063B
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 15:06:57 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id hy10so545625vcb.16
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 06:06:55 -0700 (PDT)
In-Reply-To: <20141017094838.GA1820@sirena.org.uk>
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

On Fri, Oct 17, 2014 at 2:48 AM, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Oct 16, 2014 at 09:40:58AM -0700, Anatol Pomozov wrote:
> > Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
>
> Applied, with a fixed subject - this isn't just a warning, it's a build
> failure.
>

Thanks!
