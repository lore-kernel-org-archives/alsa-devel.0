From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: Add device tree binding for
	r8a77990
Date: Mon, 20 Aug 2018 17:30:33 -0500
Message-ID: <20180820223033.GA28364@bogus>
References: <1534492435-17859-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id BE10426766C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 00:30:35 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so28732566oib.6
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2018 15:30:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1534492435-17859-1-git-send-email-ykaneko0929@gmail.com>
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

On Fri, 17 Aug 2018 16:53:55 +0900, Yoshihiro Kaneko wrote:
> From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> 
> This patch adds the device tree binding of the r8a77990 SoC.
> 
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the devel branch of Simon Horman's renesas tree.
> 
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
