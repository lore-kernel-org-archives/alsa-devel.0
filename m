From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 22/24] ASoC: qdsp6: dt-bindings: Add
 apq8096 machine bindings
Date: Fri, 27 Apr 2018 09:18:42 -0500
Message-ID: <20180427141842.fdwhbmexf6ppfnvj@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-23-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 052222677FD
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 16:18:44 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id t1-v6so2184638oth.8
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 07:18:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-23-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 10:46:04AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,apq8096.txt     | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

Reviewed-by: Rob Herring <robh@kernel.org>
