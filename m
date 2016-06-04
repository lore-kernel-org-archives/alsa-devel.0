From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Improving status timestamp accuracy
Date: Sat, 4 Jun 2016 17:59:31 +0200
Message-ID: <946c2480-fa6e-3f72-ad04-f585e9648f52@ladisch.de>
References: <5752A005.2050309@gmail.com>
 <84551786-d910-efa0-3cc7-23a3e8f6ed8f@ladisch.de>
 <5752B0EC.3030605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DEDD6260831
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 17:59:35 +0200 (CEST)
In-Reply-To: <5752B0EC.3030605@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <consult.awy@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Young wrote:
> On 04/06/16 11:17, Clemens Ladisch wrote:
>> Alan Young wrote:
>>> I am looking at ways to get more accurate status timestamp information
>>> for various SoC drivers.
>>
>> What for?
>
> I want to know, at any given point in wall-clock time, how many samples
> have been output.

>From the buffer, or from the speaker?


Regards,
Clemens
