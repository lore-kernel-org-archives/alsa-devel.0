From: Alan Young <consult.awy@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Sun, 5 Jun 2016 17:32:41 +0100
Message-ID: <57545429.5020500@gmail.com>
References: <5752A005.2050309@gmail.com>
 <84551786-d910-efa0-3cc7-23a3e8f6ed8f@ladisch.de>
 <5752B0EC.3030605@gmail.com>
 <946c2480-fa6e-3f72-ad04-f585e9648f52@ladisch.de>
 <5752FFCE.1070301@gmail.com>
 <0570b49c-51ac-e0f9-4d87-d6da4840321d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E3ED42607F7
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 18:32:44 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id m124so44276528wme.1
 for <alsa-devel@alsa-project.org>; Sun, 05 Jun 2016 09:32:44 -0700 (PDT)
In-Reply-To: <0570b49c-51ac-e0f9-4d87-d6da4840321d@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/06/16 17:27, Clemens Ladisch wrote:
>> >Obviously the speaker would be ideal
> That is reported by snd_pcm_delay().
Not really. Typically the delay is also only reported with period-size 
accuracy.
