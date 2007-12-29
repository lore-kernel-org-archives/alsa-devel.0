From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Intel Corporation 82801H (ICH8 Family) HD Audio
	Controller (rev 03)
Date: Sat, 29 Dec 2007 16:30:57 -0500
Message-ID: <75b66ecd0712291330o28d7b191v3a23cddeb54bbe06@mail.gmail.com>
References: <477028EE.9040404@googlemail.com>
	<1198815922.3732.238.camel@razman.gruemaster.com>
	<4774DB7C.4060109@googlemail.com>
	<1198853261.3732.265.camel@razman.gruemaster.com>
	<477510EB.10108@googlemail.com> <4775169A.3010801@gmail.com>
	<47753BBC.5040202@googlemail.com>
	<1198866428.3732.280.camel@razman.gruemaster.com>
	<477564ED.3000101@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D60E72451F
	for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2007 22:30:58 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so2499744rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2007 13:30:57 -0800 (PST)
In-Reply-To: <477564ED.3000101@googlemail.com>
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
To: =?ISO-8859-1?Q?Michael_K=FChn?= <breiteseite1337@googlemail.com>
Cc: "Daniele (Mastro)" <daniele.bilug@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 28, 2007 4:04 PM, Michael K=FChn <breiteseite1337@googlemail.com> wr=
ote:
> It seems that it doesn't work with kernel-built-in ALSA...
> No Sound ouput =3D(
>

You should build ALSA as modules anyway, so you can reload drivers
without rebooting.

Lee
