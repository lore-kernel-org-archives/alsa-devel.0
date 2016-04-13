From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2 v5] ASoC: dwc: Update DOCUMENTATION for I2S Driver
Date: Wed, 13 Apr 2016 15:17:09 -0500
Message-ID: <20160413201708.GA24579@rob-hp-laptop>
References: <cover.1460384521.git.joabreu@synopsys.com>
 <a922e60747eb00182eba573baf9497fff8772337.1460384521.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a922e60747eb00182eba573baf9497fff8772337.1460384521.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2016 at 01:56:28PM +0100, Jose Abreu wrote:
> This patch updates documentation for the Designware I2S
> driver.
> 
> Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---
> 
> Changes v4 -> v5:
> * interrupts is now required property
> * Drop 'snps-use-dmaengine' property
> 
> This patch was only introduced in v4.
> 
>  Documentation/devicetree/bindings/sound/designware-i2s.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
