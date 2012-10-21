From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: [PATCH 1/1] Add USB audio quirk supporting Roland
 VG-99 advanced mode
Date: Sun, 21 Oct 2012 10:34:57 +0100
Message-ID: <CABn3OEF1-y_kP428Y_-Vr3kk+YS4B7wktqrP6xOcT3B__5QKDg@mail.gmail.com>
References: <1350723664-7368-1-git-send-email-pete.leigh@gmail.com>
 <s5hpq4cjjzu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C34162650D7
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 11:34:58 +0200 (CEST)
Received: by mail-ia0-f179.google.com with SMTP id k25so1275594iah.38
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 02:34:58 -0700 (PDT)
In-Reply-To: <s5hpq4cjjzu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 21 October 2012 09:40, Takashi Iwai <tiwai@suse.de> wrote:

> Could you give a bit more descriptive commit log?
> I see you put more in comments, but it'd be also good to have more
> information in the changelog.

Ok, done I hope.

Perhaps it's worth noting - I ran the patch checking script, and it
did not like the spaces after '&', nor line lengths, in a couple of
places in the patch, but I obeyed the conventions of the existing code
in the file rather than what the script said, and kept things as they
were. Hope that's ok.

Cheers.

- Pete.
