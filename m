From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: sdm845: Update slot_width for Quaternary TDM
 port
Date: Wed, 21 Nov 2018 09:22:00 +0000
Message-ID: <15985969-695c-2e5e-88b5-f798395d1319@linaro.org>
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
 <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 16/11/18 07:41, Rohit kumar wrote:
> Change slot_width for quaternary TDM port to 16 and
> update bclk rate for TDM and MI2S interfaces
> accordingly.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org> > ---
>   sound/soc/qcom/sdm845.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
