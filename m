From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Sound streaming application: which device to use?
Date: Tue, 9 Jun 2009 22:42:21 -0400
Message-ID: <75b66ecd0906091942vae43f8bq2162fe3832ec424e@mail.gmail.com>
References: <45c981ab0906040428v3910cbcfq7e3024b23f6653e1@mail.gmail.com>
	<45c981ab0906090701t209abbc6jda420e4e666c5198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id CBA6E243EE
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 04:42:21 +0200 (CEST)
Received: by ewy23 with SMTP id 23so478399ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 19:42:21 -0700 (PDT)
In-Reply-To: <45c981ab0906090701t209abbc6jda420e4e666c5198@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lex Wassenberg <lex.wassenberg@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 9, 2009 at 10:01 AM, Lex Wassenberg<lex.wassenberg@gmail.com> wrote:
> Is there nobody that can help me out on the questions above? I figured
> the answer to question 4 (passing a pointer to an uninitialized
> integer; I thought the integer was only used for reporting back, which
> is not true), but all other questions still stand. Nobody??

You don't provide enough info.  What soundcard?  What distro?  What is
the output of  "aplay -v file.wav" when file.wav is the same audio
format your app uses?

Lee
