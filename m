From: Rob Herring <robh@kernel.org>
Subject: Re: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060
 property out-single-ended
Date: Tue, 4 Dec 2018 15:43:13 -0600
Message-ID: <20181204214313.GA7847@bogus>
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115071253.22558-1-kmarinushkin@birdec.tech>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Nov 2018 08:12:53 +0100, Kirill Marinushkin wrote:
> Output of pcm3060 codec may be configured as single-ended or differential
> 
> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
> Cc: devicetree@vger.kernel.org
> ---
> Hello Mark,
> 
> yesterday there was a misunderstanding: when I wrote you
> 
> > I think you forgot one patch in the series
> 
> you accidently applied the already-applied patch instead of the forgotten
> one. To avoid the confusion, in this e-mail I resend you the proper
> forgotten patch in a separate mailing thread.
> 
> Please apply this patch for-next.
> 
> Best Regards,
> Kirill
> ---
>  Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
