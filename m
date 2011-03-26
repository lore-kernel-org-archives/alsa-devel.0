From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: twl6040: Return -ENOMEM if
 create_singlethread_workqueue fails
Date: Sat, 26 Mar 2011 15:53:55 +0000
Message-ID: <1301154835.3455.54.camel@odin>
References: <1301126038.7662.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C9795244D0
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 16:53:58 +0100 (CET)
Received: by wwf26 with SMTP id 26so1355847wwf.20
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 08:53:58 -0700 (PDT)
In-Reply-To: <1301126038.7662.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-03-26 at 15:53 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/twl6040.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 

Applied.

Thanks

Liam
