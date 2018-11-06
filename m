From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: GitHub - alsa-project - repositories
Date: Tue, 6 Nov 2018 10:04:46 +0100
Message-ID: <09ff9777-0916-d991-7acb-6d6e7f9fe657@perex.cz>
References: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
 <20181105125439.GX12092@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C31A267839
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 10:04:50 +0100 (CET)
In-Reply-To: <20181105125439.GX12092@vkoul-mobl>
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
To: Vinod Koul <vkoul@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 5.11.2018 v 13:54 Vinod Koul napsal(a):
> On 05-11-18, 09:49, Jaroslav Kysela wrote:
>> Hi all,
>>
>>   URL: https://github.com/alsa-project
>>
>>   I finally finished the first phase of the integration with GitHub. All
>> repositories are now on GitHub and all repositories are mirrored to
>> alsa-project.org. The github repositories are master (developers should
>> push changes only to those repositories). If you refer the repository as
>> the code source (for packaging or so), please, keep to use the
>> repositories on alsa-project.org (in case when we migrate to other
>> service in future like GitLab or so). The mirroring is realtime, so the
>> changes should be visible on git.alsa-project.org in few seconds after
>> the push.
>>
>>   I invited few people to the GitHub team and actually Takashi has full
>> access to all repos, Vinod Koul should have the write access to
>> tinycompress and Takashi Sakamoto should have the write access to
>> alsa-gi. If I omitted someone (or someone is not on github), please, let
>> me know (and register before).
> 
> Thanks Jaroslav,
> 
> I guess first thing I need is to update my email id :-)
> 
> Btw how would the sync be done wrt git.alsa-project.org repos and github
> or we should move to github starting .... ?

The github repos are master (there is no bi-directional sync). Please,
push to github only.

					Jaroslav

---
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
