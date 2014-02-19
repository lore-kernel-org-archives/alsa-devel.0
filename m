From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4271: claim reset GPIO in bus
	probe function
Date: Wed, 19 Feb 2014 16:30:20 +0000
Message-ID: <8B5CBE55-B191-434F-B50A-581A75E27C70@cirrus.com>
References: <1392815154-24728-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 04A88265A77
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:30:28 +0100 (CET)
In-Reply-To: <1392815154-24728-1-git-send-email-zonque@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "subaparts@yandex.ru" <subaparts@yandex.ru>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



> On Feb 19, 2014, at 7:06, "Daniel Mack" <zonque@gmail.com> wrote:
> 
> Move the GPIO acquisition from the codec to the bus probe functions.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>
