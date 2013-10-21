From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mxc-spdif delay: miss 1-2s at the beginning of the
 song
Date: Mon, 21 Oct 2013 14:06:27 +0200
Message-ID: <526518C3.20603@ladisch.de>
References: <525D4F5B.6050105@gmail.com> <52651502.7000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E3066260795
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 14:06:29 +0200 (CEST)
In-Reply-To: <52651502.7000608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?st=E9phane_cerveau?= <scerveau@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

st=E9phane cerveau wrote:
> Concerning the music startup i still have some issues with sync.
> For now i put a delay in playback start but this is not clearly
> fixing the issue and this is not a solution for me.

Are you sure that the problem isn't that the receiver is slow
to lock on?


Regards,
Clemens
