From: Naoki Matsumoto <n-matsumoto@melcoinc.co.jp>
Subject: Re: [RFC] Merge DSD_U32_BE devices list
Date: Wed, 8 Mar 2017 21:08:10 +0900
Message-ID: <898aa4c2-94be-e3fe-6f93-16bcc0a73f1c@melcoinc.co.jp>
References: <7117b647-e9ba-a182-4a4d-8182ef77e2a0@melcoinc.co.jp>
 <1488903465.2443.1.camel@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.melco.ne.jp (smtp.melco.ne.jp [113.37.91.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 9039926690D
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 13:08:15 +0100 (CET)
In-Reply-To: <1488903465.2443.1.camel@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hello Jurgen

On 2017/03/08 1:17, Jurgen Kramer wrote:
> Hello Naoki,
>
> On Tue, 2017-03-07 at 15:53 +0900, Naoki MATSUMOTO wrote:
>> Dear Mr.lintweaker
>> CC:alsa-ml
>>
>> Hello nice to meet you.
>> I know that you work for xmos-native-dsd.
>> You has contributed linux, alsa-lib and mpd.
>> You have patches of xmos-native-dsd device list on github.
>> https://github.com/lintweaker/xmos-native-dsd/tree/master/SRPMS/patch
>> es/kernel
>> so, I want to merge upstreame kernel. because, MPD 0.20 over support
>> DSD_U32_BE.
>>
>> Current kernel has few support devices.
>> https://patchwork.kernel.org/project/alsa-devel/list/?q=dsd
>>
>> I want to create patch. Could you please tell me anything problems?
>>
> I am planning on sending in a patch(set) adding all remaining devices
> not in the kernel yet. Time frame: +/- 2 weeks.
Sounds good! Then I wait for your work.
If we find new xmos-dsd sound device, we send patch to alsa-dev Just like you.
However, we don't have it yet :)

Thank you!
Naoki
