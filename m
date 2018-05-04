From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: cs42xx8: Make the node name
	generic
Date: Fri, 4 May 2018 17:25:32 -0500
Message-ID: <20180504222532.GD13133@rob-hp-laptop>
References: <1525461123-16686-1-git-send-email-festevam@gmail.com>
 <1525461123-16686-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C10C0267235
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 00:25:34 +0200 (CEST)
Received: by mail-oi0-f43.google.com with SMTP id k5-v6so13675439oiw.0
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 15:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1525461123-16686-4-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 04, 2018 at 04:12:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> According to Devicetree Specification v0.2 document:
> 
> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming model."
> 
> Do as suggested in the binding example.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/cs42xx8.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.
