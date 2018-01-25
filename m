From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: Re: Applied "ASoC: hdac_hdmi: Ensuring proper setting
 of output widget power state" to the asoc tree
Date: Thu, 25 Jan 2018 18:43:48 +0530
Message-ID: <f143e1a8-69a0-ba39-f0e1-e2e05a953f17@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <E1ea6ZJ-0003BS-KB@debutante> <20180112212012.GI21458@sirena.org.uk>
 <20180115061216.GS18649@localhost> <20180115103040.GB7333@sirena.org.uk>
 <20180115104153.GB18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 8548B267205
 for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2018 14:13:57 +0100 (CET)
In-Reply-To: <20180115104153.GB18649@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org



On 1/15/2018 4:11 PM, Vinod Koul wrote:
> On Mon, Jan 15, 2018 at 10:30:40AM +0000, Mark Brown wrote:
>> On Mon, Jan 15, 2018 at 11:42:16AM +0530, Vinod Koul wrote:
>>> On Fri, Jan 12, 2018 at 09:20:12PM +0000, Mark Brown wrote:
>>>> I've dropped this because it caused a conflict with the topic/hdac-hdmi
>>>> branch - can you please check what's going on there?  I merged that into
>>>> the topic/intel branch so probably just a rebase is needed.
>>> I do not think this is ready yet. Takashi and me have few comments on
>>> this...
>> There were comments on v1 but nobody responded to v2.
> yeah we were still stuck on v1 :) I think Abhijeet will post an update once
> we align..

Hi, I 've posted the latest series on ALSAdev mailing list. Kindly 
review. :)
https://patchwork.kernel.org/patch/10180821/
https://patchwork.kernel.org/patch/10180825/
https://patchwork.kernel.org/patch/10180827/
>
