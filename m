From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2 2/5] ASoC: qcom: sdm845: Create and setup jack in init
 callback
Date: Mon, 10 Dec 2018 15:35:07 +0530
Message-ID: <3a99d252-1648-c6e3-e7db-1df2e6d33801@codeaurora.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
 <20181128090037.257359-2-cychiang@chromium.org>
 <20181206202156.GD3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206202156.GD3084@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org

Hello Mark,


On 12/7/2018 1:51 AM, Mark Brown wrote:
> On Wed, Nov 28, 2018 at 05:00:34PM +0800, Cheng-Yi Chiang wrote:
>> Add a callback for init ops on dai_link to create and setup jack.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> This looks like you're forwarding a patch from Rohit but shows you as
> the author?

This was co-authored by me and Cheng-Yi. However, change is already 
merged from v1 itself.

Thanks,
Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.
