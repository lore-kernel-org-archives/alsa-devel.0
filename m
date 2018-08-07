From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: Document R-Car M3-N support
Date: Tue, 7 Aug 2018 12:01:34 -0600
Message-ID: <20180807180134.GA6871@rob-hp-laptop>
References: <1532551215-14868-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 47062267898
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 20:01:37 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id e14-v6so36039itf.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2018 11:01:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1532551215-14868-1-git-send-email-ykaneko0929@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 26, 2018 at 05:40:15AM +0900, Yoshihiro Kaneko wrote:
> From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> 
> Document support for the sound modules in the Renesas M3-N (r8a77965)
> SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the devel branch of Simon Horman's renesas tree.
> 
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
