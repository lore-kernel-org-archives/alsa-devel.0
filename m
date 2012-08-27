From: Daniel Mack <zonque@gmail.com>
Subject: Re: REGRESSION: Webcam mic for 145f:015b not longer
 working with 1.0.24 and above (OK with 1.0.23)
Date: Mon, 27 Aug 2012 11:26:32 +0200
Message-ID: <503B3D48.5030206@gmail.com>
References: <503B372B.4050807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E3943265E33
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 11:56:42 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so989596bkc.38
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 02:56:42 -0700 (PDT)
In-Reply-To: <503B372B.4050807@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kostas <hunter18@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27.08.2012 11:00, Kostas wrote:
> Hi All,
> 
> I have a 'Trust Webcam' (USB ID: 145f:015b) that comes with a microphone.
> The microphone works with Alsa 1.0.23 but it does not work with the 
> latest Alsa 1.0.25 neither with Alsa 1.0.24.
> Apparently this is a regression.
> 
> What shall I do to figure out the source of the problem?
> 
> Here are attached my alsa-infos, with Alsa 1.0.23 (working), 1.0.24 (NOT 
> working) and 1.0.25 (NOT working).

Can you provide dmesg protocols for both a working and a non-working
case please?
