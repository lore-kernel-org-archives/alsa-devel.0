From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Vorbis-dev] libao problem (Re: No dmix/dsnoop on
 Intel ICH4/5 by default?)
Date: Sun, 24 Mar 2013 21:01:43 +0100
Message-ID: <514F5BA7.5020105@gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
 <50F7D0E3.3020401@gmail.com> <50F7EAA1.7040504@ladisch.de>
 <50F7F23C.4070006@gmail.com>
 <CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>
 <514F36F6.8080806@gmail.com>
 <CACrD=+_whofChWJU+hVR3opb_baHvTjqmLzWrbQAqu9r08GCPQ@mail.gmail.com>
 <514F4B0C.8020309@ladisch.de>
 <CACrD=+8GwH6Euza1WrsKuuav=JPE5wbLMZAFQZHajKU3P0E7xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tb.mail.iss.as9143.net (smtpq1.tb.mail.iss.as9143.net
 [212.54.42.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 431C2260315
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 21:01:53 +0100 (CET)
In-Reply-To: <CACrD=+8GwH6Euza1WrsKuuav=JPE5wbLMZAFQZHajKU3P0E7xA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiphmont@xiph.org
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 24-03-13 20:43, xiphmont@xiph.org wrote:

>> The SND_PCM_NO_AUTO_* flags are there for exactly this reason:
>> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga64fa40b556374dabe40d4874242fee19
>
> Ahhh, very good. Yes, I can improve the situation given these flags.

Great. If you keep me in the loop, I'll get dev=default removed in arch 
linux again once it has.

Regards,
Rene
