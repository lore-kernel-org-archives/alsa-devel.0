From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Remove dynamic configuration from alsa-lib
Date: Tue, 3 Jul 2007 15:15:15 -0400
Message-ID: <75b66ecd0707031215m609685aje041010626d7a5d@mail.gmail.com>
References: <468A9F7E.3030806@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.228])
	by alsa0.perex.cz (Postfix) with ESMTP id B733410383D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 21:15:16 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id q12so2205721qba
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 12:15:15 -0700 (PDT)
In-Reply-To: <468A9F7E.3030806@tse.gov.br>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/3/07, Fausto Carvalho Marques SIlva <fausto@tse.gov.br> wrote:
> I have a hard job...to remove dynamic configuration from alsa-lib
> (conf.c,confmisc.c).
> I found it difficult because snd_conf_* functions are spread all over
> *.c files.
> Is there am easy way of doing it ? Does anyone have some "guidelines" of
> doing it?

I doubt there's an easy way - why would you want to do that?

Lee
