From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH 0/5] Alsa: snd-usb: Improve M-Audio Fast
 Track Ultra mixer - v3
Date: Mon, 23 Apr 2012 19:47:45 +0100 (BST)
Message-ID: <alpine.LNX.2.01.1204231943200.20159@stax.localdomain>
References: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Apr 2012, Felix Homann wrote:

[...]
> BTW, you might like to add some TLV callback to the Ebox-44 controls as 
> well.

I can, but I'll need some assistance or documentation to explain how. I 
took a quick look, and it wasn't very clear.

I presume this adds dB values to the mixer? Unless I have taken some 
measurements is it not better to leave them unassigned than add bogus 
values?

Thanks

-- 
Mark
