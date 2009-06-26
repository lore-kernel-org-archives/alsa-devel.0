From: Julien Claassen <julien-A9sl9eYVDUc@public.gmane.org>
Subject: Re: [LAU] Laptop speakers nonfunctional, jacks functional
Date: Fri, 26 Jun 2009 23:50:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64L.0906262348520.18701@arima>
References: <10c3cb270906261405n3987a549x67cdf298176f6db7@mail.gmail.com>
	<10c3cb270906261434l65c0bf8dp3aa44ba5f2c2201d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <10c3cb270906261434l65c0bf8dp3aa44ba5f2c2201d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Ludwig Maes <ludwig.maes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

One idea: Is your jack a combined RCA/stereo jack? If so, windows might have 
some code to switch between the two. But ALSA doesn't properly recognise, when 
no jack is in.
   Regards
         Julien

--------
Music was my first love and it will be my last (John Miles)

======== FIND MY WEB-PROJECT AT: ========
http://ltsb.sourceforge.net
the Linux TextBased Studio guide
======= AND MY PERSONAL PAGES AT: =======
http://www.juliencoder.de
