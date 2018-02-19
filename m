From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add DT bindings documentation
 for max9759 amplifier
Date: Mon, 19 Feb 2018 14:47:59 -0600
Message-ID: <20180219204759.aofqbmmxc7sys2wc@rob-hp-laptop>
References: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
 <1519047958-22583-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D743266DFD
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 21:48:01 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id u6so7985967oiv.9
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 12:48:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1519047958-22583-2-git-send-email-narmstrong@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 19, 2018 at 02:45:57PM +0100, Neil Armstrong wrote:
> This patch adds DT bindings documentation for Maxim MAX9759
> speaker amplifier.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/sound/maxim,max9759.txt        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt

Reviewed-by: Rob Herring <robh@kernel.org>
